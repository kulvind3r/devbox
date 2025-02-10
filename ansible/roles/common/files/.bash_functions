function log() {
    MSG="$1"
    TIMESTAMP=$(date '+%b %d %H:%M:%S')
    echo "=== $TIMESTAMP - $MSG ==="
}

function login_eks() {
    CLUSTER_NAME=$1
    REGION=$2

    [[ $REGION = "us" ]] && AWS_REGION="us-east-1"
 
    [[ -z $CLUSTER_NAME ]] && { log "Cluster name not provided. usage 'login_eks <cluster_name> <region_name>'."; return; }
    [[ -z $AWS_REGION ]] && { log "Provided region not supported. usage 'login_eks <cluster_name> <region_name>'"; return; }

    aws sts get-caller-identity > /dev/null || { log "AWS Credentials check failed. Make sure you are logged in awscli"; return; }

    aws eks update-kubeconfig --name $CLUSTER_NAME --region $AWS_REGION
}
