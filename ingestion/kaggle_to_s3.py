import kaggle
import boto3
import os


def download_kaggle_dataset():
    print("Downloading Olist dataset from Kaggle...")
    kaggle.api.authenticate()
    kaggle.api.dataset_download_files(
        'olistbr/brazilian-ecommerce',
        path='./data',
        unzip=True
    )
    print("Download complete!")


def upload_to_s3(bucket_name):
    print("Uploading files to S3...")
    s3 = boto3.client('s3')

    for file in os.listdir('./data'):
        if file.endswith('.csv'):
            print(f'Uploading {file}...')
            s3.upload_file(
                f'./data/{file}',
                bucket_name,
                f'raw/{file}'
            )
            print(f'{file} uploaded!')

    print("All files uploaded to S3!")

if __name__ == "__main__":
    BUCKET_NAME = "olist-raw-data-806608358790-us-east-1-an"
    download_kaggle_dataset()
    upload_to_s3(BUCKET_NAME)