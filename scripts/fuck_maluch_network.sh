# Credentials are exposed but I don't give a crap, stupid network.
# Apparently there is not a rate limiter, because I've been  using for 24h straight
# Ubuntu 23.10 automatically reconnects, but earlier versions don't. That is odd...

while true
do
    datetime=$(date +"%Y-%m-%d %H:%M:%S")
    response=$(curl -s -o /dev/null -w "%{http_code}" -X POST "http://172.28.0.1:8090/index.php" -H "Content-Type: application/x-www-form-urlencoded" -d "login=fursim4744&password=kfbzh6qs&submitlogin=Submit")

    if [ "$response" -eq 200 ]; then
        echo "$datetime\t\033[32mOK\033[0m"
    else
        echo "$datetime\t\033[31mERROR\033[0m\t$response"
    fi

    sleep 3
done

