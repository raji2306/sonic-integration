import requests
import os

auth = ("username", "password")
# Alternative way is auth = (os.environ.get("user"), os.environ.get("pass"))
url = "repo_url"
target_directory = "/Purley-Artifacts/Test/"

#Uploading the artifacts into the Artifactory Repo 

def upload_file():
    
    file_name = input("Enter the file name: ")
    target_directory = "/Purley-Artifacts/Test/"

    with open(file_name, "rb") as file:
        response = requests.put(url + target_directory + file_name, auth=auth, data=file)

    if response.status_code == 200 | 201 :
        print("Artifact was uploaded successfully")

    else:
        print(f"Failed to upload, please check path and try again : {response.status_code}")

#Downloading the artifacts from the Artifactory Repo 

def download_file():
    root_directory = "C:/"
    sub_directory = input("Enter the folder name that you wants to create for storing the Artifacts :   ")

    working_dir = os.path.join(root_directory, sub_directory)

    if not os.path.exists(working_dir):
        os.mkdir(working_dir)
    else:
        print(f"Directory already exists.")

    #Creating a file to store data 
    
    download_fileName = input("Enter the file name that you want to download from AF repo :   ")
    download_file_path = os.path.join(working_dir, download_fileName)
    repo_subPath = "/Purley-Artifacts/Test/"

    with open('donwloaded_filename', 'w') as fp:
        print("file got created successfully, ")

    check_availability = requests.get(url + repo_subPath + download_fileName, auth=auth )

    if check_availability.status_code == 200 :
        with open (download_file_path, "wb") as file :
            file.write(check_availability.content)
        print("Successfully downloaded the file on your machine")
    else : 
        print("Failed to download the file, Verify whether the file or located or not")

#Deleting the Artifacts

def delete_artifact():
    
    filename = input ("Enter the file that you wants to delete from repo :  ")
    response = requests.delete(url + target_directory + filename, auth=auth)

    if response.status_code in [200, 201, 202, 203, 204]:
        print("Artifact deleted successfully")
    else:
        print(f"Failed to delete the artifact. Status code: {response.status_code}")

#Listing the Artifacts 

def list_artifacts():

    url1 = "https://ubit-artifactory-sh.intel.com/artifactory/api/storage/one-windows-local/"
    target_directory = input("Enter the folder path that you want to check :  ")
    responses = requests.get(url1 + target_directory, auth=auth)

    if responses.status_code == 200 :
        data=responses.json()
        print("The files and folders under ", target_directory)
        for item in data["children"]:
            print( item["uri"])
    else:
        print("Couldn't find files or folder under the ", target_directory)

if __name__ == "__main__" :
   while True:
    choice = input ("For uploading - type 'upload' , for downloading - type 'download', for deletion - type 'delete', for listing - type 'list' :  ").lower()

    if choice=="upload" :
        upload_file()
    elif choice=="download" :
        download_file()
    elif choice=="delete" :
        delete_artifact()
    elif choice=="list":
        list_artifacts()
    else :
        print ("Kindly choose correct option to proceed") 
