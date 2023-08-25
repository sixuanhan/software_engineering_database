# software_engineering_database: CareerCode

This is the submission of the fourth milestone.

## Database Features and Enhancements: frontend and visualization

Since the datasets contained rich information in the raw form and my initial vision was to provide users with a fast yet flexible way of job search, I decided to focus on the READ function among CRUD. Therefore, I chose to build a frontend that simplifies querying and provides visualization to maximize user experience.

### Retool

After exploring resources, I have discovered a tool called Retool. Retool is a platform that enables developers to quickly build internal tools, dashboards, and applications using a simple drag-and-drop interface, connecting to various data sources and APIs without extensive coding, thus streamlining and accelerating the development process.

Here is their [landing page](https://retool.com/?_keyword=retool&adgroupid=77096230789&utm_source=google&utm_medium=search&utm_campaign=6470119914&utm_term=retool&utm_content=651185010950&hsa_acc=7420316652&hsa_cam=6470119914&hsa_grp=77096230789&hsa_ad=651185010950&hsa_src=g&hsa_tgt=kwd-395242915847&hsa_kw=retool&hsa_mt=e&hsa_net=adwords&hsa_ver=3&gad=1&gclid=Cj0KCQjw_5unBhCMARIsACZyzS096RdAyxfwzTTv78VW3UrBzXE2PuFhg_epKdwFFZ_sYrTlnIp9kAIaAjHnEALw_wcB).

#### deploy Retool on AWS EC2

##### launch an EC2 instance

[Tutorial: Get started with Amazon EC2 Linux instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EC2_GetStarted.html)
- Launch an Amazon Ubuntu EC2 instance on AWS.
- Use the standard key-pair that I used for class labs.
- Connect to instance with:
  ```bash
  ssh -i Downloads/sixuan-gc-key.pem ubuntu@<public-ip-address>
  cd retool-onpremise-master
  sudo docker-compose up -d
  ```

  then go to `http://<public-ip-address>:3000/auth/login`

##### deploy Retool with docker-compose
[Tutorial: Deploy Self-hosted Retool with Amazon EC2](https://docs.retool.com/self-hosted/quickstarts/ec2)

Bugs in the documentation and how to fix:

1. need to download docker-compose

2. invalid interpolation format
   
   Fix: [How to Fix the Invalid Interpolation Format Error in Docker Compose](https://improveandrepeat.com/2022/08/how-to-fix-the-invalid-interpolation-format-error-in-docker-compose/)
   
   need to change docker-compose version from 2 to 2.1

3. [install docker in Ubuntu in AWS EC2](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository)

4. out of space
   Fix: upgrade instance to 16GB storage.

5. "ip does not provide any data" after putting `<public-ip-address>/auth/signup` in the browser
   
   Fix: need to put port after ip address: `<public-ip-address>:3000/auth/signup`

6. interval service error when putting in correct username and password
   
   Fix: after checking the docker logs, found:

    ``` JSON
    {"level":"error","msg":"Internal server error: secretOrPrivateKey must have a value","pid":84,"requestId":"6436a228-84c0-4f3e-a614-2d4b90018c8b","stack":"Error: secretOrPrivateKey must have a value\n    at Object.module.exports [as sign] (/node_modules/jsonwebtoken/sign.js:105:20)\n    at xC (/retool_backend/bundle/main.js:168:15732)\n    at zf (/retool_backend/bundle/main.js:1792:10550)\n    at /retool_backend/bundle/main.js:1792:9974\n    at runMicrotasks (<anonymous>)\n    at processTicksAndRejections (node:internal/process/task_queues:96:5)","timestamp":"2023-08-20T03:30:56.995Z","type":"INTERNAL_ERROR"}
    ```

    Found relevant debugging article on [Error: secretOrPrivateKey must have a value](https://stackoverflow.com/questions/58673430/error-secretorprivatekey-must-have-a-value), so changed private key in `docker.env`.

#### connecting Retool to my database

I created an AWS RDS, but could not connect to MySQL Workbench no matter what, so I connected the RDS to the EC2 instance and was able to make connection to Self-hosted Retool and then migrate data with Retool.

I went to MySQL Workbench -> administration -> management -> data export and used the dump method to create [a sql file](dump.sql) that contains the migration. I used the sql file in Retool to finih the migration.

#### building front-end with Retool

[Web app tutorial](https://docs.retool.com/apps/web/tutorial/)

[Building Your First Retool App: Product Walkthrough
](https://www.youtube.com/watch?v=lqFgt4_BS6o&list=PLqWdQFDVLADmCPoQLWJ0G137Z2zExXOGu&index=14)

I mainly used the table component (both the new version and the legacy version, because only the legacy version supports dynamic column settings), chart, text, text input boxes (text search), search boxes (drop downs).

Find a video demonstration of the app [here](demo.mp4).

### Next steps

- The current UI does not look pretty. Can integrate CSS (I could not figure out how to do that in the low-code platform. I had already spent 10 hours on this task in total by then) to make the front-end look more pretty. Here is a [UI low-fidelity design](UI_demo.mp4) that I made with Figma, indicating how it could look like.
- The current website only supports searching by a few attributes. Ideally, the website would enable searching with any of the existing attributes.
- Update: the users could contribute to the database by updating it with the latest information on the companies, city data, etc. Of course, with the permission of the admin.
- Automation: keeps track of relevant datasets and update data automatically when new data is updated (eg. a new release of the fortune 500 rank).
