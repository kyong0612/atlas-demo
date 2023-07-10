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


PHOBY: new
new: 
	atlas migrate new


PHOBY: baseline
baseline:
	atlas migrate diff my_baseline \
		--dir "file://migrations" \
		--dev-url "docker://mysql/8/my_schema" \
		--to "mysql://root:pass@localhost:3306/example"

PHOBY: apply
apply:
	atlas migrate apply \
  		--url "mysql://root:pass@localhost:3306/example" \
		--dir "file://migrations" \
  		--baseline "20230710040611"

PHOBY: set-history
set-history:
	atlas migrate set \
 		--url "mysql://root:pass@localhost:3306/example" \
  		--dir "file://migrations"

VERSION = 20230710040644
PHOBY: down
down:
	atlas schema apply \
  		--url "mysql://root:pass@localhost:3306/example" \
		--to "file://migrations?version=$(VERSION)" \
  		--dev-url "docker://mysql/8/example"
	
	atlas migrate set $(VERSION) \
  		--url "mysql://root:pass@localhost:3306/example" \
  		--dir "file://migrations"

PHOBY: hash
hash:
	atlas migrate hash


