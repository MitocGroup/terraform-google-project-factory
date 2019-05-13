import os
import json
import subprocess

def main():
    component = '{"project_default":"s3://data-lake-terrahub-us-east-1/AWSLogs/tfvars/terraform-google-project-factory/project_dafault/default.tfvars","project_default_service_account":"s3://data-lake-terrahub-us-east-1/AWSLogs/tfvars/terraform-google-project-factory/project_dafault/default.tfvars"}'
    components = eval(component)
    # components = json.load(os.environ['components'])
    includ = []
    for (k, v) in components.items():
        includ.append(k)
        print("Key: " + k)
        print("Value: " + str(v))
        args = ['terrahub', 'configure', '-i', k, '-c', "terraform.varFile[0]='" + str(v) + "'"]
        subprocess.Popen(args)
    includ = ','.join(includ)

    args = ['terrahub', 'init', '-i', includ]
    subprocess.Popen(args)


    return {
        "components": components
    }

if __name__ == '__main__':
    RESP = main()
    # print(RESP)

    # with open('output.json', 'w') as json_file:
    #     json.dump(RESP, json_file)