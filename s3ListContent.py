import boto3
import logging
from flask import Flask, jsonify
from botocore.exceptions import NoCredentialsError, PartialCredentialsError, ClientError

logger = logging.getLogger(__name__)

class S3Client:
    """Class to interact with the AWS S3 API."""

    def __init__(self, bucket_name: str, region: str):
        self.bucket_name = bucket_name
        self.region = region
        self.client = boto3.client('s3', region_name=region)

    def list_objects(self, prefix: str = '') -> list:
        """List objects in the S3 bucket given a prefix."""
        try:
            logger.info(f"Listing objects in bucket: {self.bucket_name} with prefix: {prefix}")
            response = self.client.list_objects_v2(Bucket=self.bucket_name, Prefix=prefix, Delimiter='/')
            return response.get('CommonPrefixes', [])
        except (NoCredentialsError, PartialCredentialsError):
            logger.error("Access denied: Invalid AWS credentials")
            raise PermissionError("Access denied: Invalid AWS credentials")
        except ClientError as e:
            if e.response['Error']['Code'] == 'AccessDenied':
                logger.error("Access denied: You do not have permission to access this bucket")
                raise PermissionError("Access denied: You do not have permission to access this bucket")
            logger.error(f"Client error: {e}")
            raise e
        except Exception as e:
            logger.error(f"Error accessing S3: {e}")
            raise Exception(f"Error accessing S3: {e}")

class S3ContentService:
    """Service class that provides functionality to list contents of the S3 bucket."""

    def __init__(self, s3_client: S3Client):
        self.s3_client = s3_client

    def get_content(self, path: str = '') -> list:
        """Get the content of a specified path in the S3 bucket."""
        prefix = path.rstrip('/') + '/' if path else ''
        directories = self.s3_client.list_objects(prefix)
        logger.info(f"Retrieved content for path: {path}")

        # Extract directory names from the response
        if directories:
            content = [prefix['Prefix'].split('/')[-2] for prefix in directories]
            return content
        else:
            return []

def create_app() -> Flask:
    """Create and configure the Flask application."""
    # Define the S3 bucket and region
    S3_BUCKET = 's3-bucket-name'
    AWS_REGION = 'aws-region'
    app = Flask(__name__)

    # Initialize S3 client and service
    s3_client = S3Client(S3_BUCKET, AWS_REGION)
    s3_content_service = S3ContentService(s3_client)

    # Define the routes
    @app.route('/list-content/', defaults={'path': ''}, methods=['GET'])
    @app.route('/list-content/<path:path>', methods=['GET'])
    def list_bucket_content(path: str):
        """Endpoint to list the content of a specific S3 path."""
        try:
            logger.info(f"Request received to list content for path: {path}")
            content = s3_content_service.get_content(path)
            if not content:
                logger.warning(f"Content not found for path: {path}")
                return jsonify({"error": "Content not found"}), 404
            return jsonify({"content": content})
        except PermissionError as e:
            logger.error(f"Permission error: {e}")
            return jsonify({"error": str(e)}), 403
        except Exception as e:
            logger.error(f"Server error: {e}")
            return jsonify({"error": str(e)}), 500

    return app

if __name__ == '__main__':
    # Run the Flask app
    app = create_app()
    logger.info("Starting Flask app...")
    app.run(debug=True, host='0.0.0.0', port=5000)  # http://127.0.0.1:5000/list-content
