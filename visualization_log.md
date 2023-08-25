## deploy Retool on AWS EC2

### step 1
[Tutorial: Get started with Amazon EC2 Linux instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EC2_GetStarted.html)


- Launch an Amazon Ubuntu EC2 instance on AWS.
- Use the standard key-pair that I used for class labs.
- Connect to instance with: 
  ```bash
  ssh -i Downloads/sixuan-gc-key.pem ubuntu@<public-ip-address>
  cd retool-onpremise-master
  sudo docker-compose up -d
  ```

  then go to http://<public-ip-address>:3000/auth/login


[Deploy Self-hosted Retool with Amazon EC2](https://docs.retool.com/self-hosted/quickstarts/ec2)
- edit inbound rules
- Your license key: SSOP_a1a33534-77ab-49ca-ab8d-8aba2e60391a
ENCRYPTION_KEY=q01/z4DkiN0OAU213h1OeT+ndHBRE/W0OwKnq3MiQJr9kCFsYcbTB60mZfD+uLWf

## Bugs and Fixes

need to download docker-compose

Fix: [How to Fix the Invalid Interpolation Format Error in Docker Compose](https://improveandrepeat.com/2022/08/how-to-fix-the-invalid-interpolation-format-error-in-docker-compose/)
need to change docker-compose version from 2 to 2.1

[install docker in Ubuntu in AWS EC2](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository)

out of space: need to upgrade instance to 16GB storage.

can't access: need to put port after ip address

interval service error: check docker logs, found 

``` JSON
{"level":"error","msg":"Internal server error: secretOrPrivateKey must have a value","pid":84,"requestId":"6436a228-84c0-4f3e-a614-2d4b90018c8b","stack":"Error: secretOrPrivateKey must have a value\n    at Object.module.exports [as sign] (/node_modules/jsonwebtoken/sign.js:105:20)\n    at xC (/retool_backend/bundle/main.js:168:15732)\n    at zf (/retool_backend/bundle/main.js:1792:10550)\n    at /retool_backend/bundle/main.js:1792:9974\n    at runMicrotasks (<anonymous>)\n    at processTicksAndRejections (node:internal/process/task_queues:96:5)","timestamp":"2023-08-20T03:30:56.995Z","type":"INTERNAL_ERROR"}
```

found relevant debugging article on [Error: secretOrPrivateKey must have a value](https://stackoverflow.com/questions/58673430/error-secretorprivatekey-must-have-a-value)

so changed private key in `docker.env`.

created AWS RDS, could not connect to MySQL Workbench no matter what, so connected to EC2 instance and was able to make connection to Self-hosted Retool.

Migrated database to AWS RDS with dump in MySQL.

[Web app tutorial](https://docs.retool.com/apps/web/tutorial/)

[Building Your First Retool App: Product Walkthrough
](https://www.youtube.com/watch?v=lqFgt4_BS6o&list=PLqWdQFDVLADmCPoQLWJ0G137Z2zExXOGu&index=14)



couldnt get dynamic column setting from table component. had to switch to the legacy component.