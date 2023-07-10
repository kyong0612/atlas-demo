include .env

PHOBY: init
inti:
	docker run --rm -d --name atlas-demo -p 3306:3306 -e MYSQL_ROOT_PASSWORD=pass -e MYSQL_DATABASE=example mysql
	docker exec atlas-demo mysql -ppass -e 'CREATE table example.users(id int PRIMARY KEY, name varchar(100))'


PHOBY: inspect
inspect:
	atlas schema inspect -u "mysql://root:pass@localhost:3306/example" --format '{{ sql . }}' > schema.sql


PHOBY: declarative-migrate
declarative-migrate:
	atlas schema apply \
  	-u "mysql://root:pass@localhost:3306/example" \
  	--to file://schema.sql \
  	--dev-url "docker://mysql/8/example"

PHOBY: diff
diff:
	atlas migrate diff create_blog_posts \
  	--dir "file://migrations" \
  	--to "file://schema.sql" \
  	--dev-url "docker://mysql/8/example"
