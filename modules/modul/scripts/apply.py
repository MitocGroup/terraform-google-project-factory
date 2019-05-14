import os
import json
import subprocess

def main():
    # component = '{"project_default":"s3://data-lake-terrahub-us-east-1/AWSLogs/tfvars/terraform-google-project-factory/project_dafault/default.tfvars","project_default_service_account":"s3://data-lake-terrahub-us-east-1/AWSLogs/tfvars/terraform-google-project-factory/project_dafault/default.tfvars"}'
    # components = eval(component)
    components = eval(os.environ['components'])
    includ = []
    for (k, v) in components.items():
        includ.append(k)
        args = ['terrahub', 'configure', '-i', k, '-c', "terraform.varFile[0]='" + str(v) + "'"]
        subprocess.Popen(args, cwd=os.environ['root'])
    includ = ','.join(includ)

    args_init = ['terrahub', 'init', '-i', includ]
    subprocess.Popen(args_init, cwd=os.environ['root'])

    return 'Succes'

if __name__ == '__main__':
    RESP = main()
    print(RESP)
