# Rails JSON & virtual fields

Some tests using Rails 5.1.x with JSON and virtual fields with MySQL (*5.7.x*) / MariaDB (*10.2.x*)

- *authors* migration: [here](db/migrate/20171013192944_create_authors.rb)
- *ref* migration: [here](db/migrate/20171013192959_add_ref_to_authors.rb)

See **Prepare models** commit to isolate the changes after initial scaffolding

## JSON fields

```rb
Author.create first_name: 'John', last_name: 'Doe', custom_data: {a_ref: 123}
Author.create first_name: 'Jim', last_name: 'Bo', custom_data: {a_ref: 456, a_nother_field: {aaa: {bbb: "ccc"}}}
Author.create first_name: 'Another', last_name: 'One', custom_data: {}

Author.where( 'custom_data->"$.a_ref" = 123' )
Author.where( ref: 123 )  # indexed key for a_ref prop
```

## Virtual fields

```rb
Author.create( first_name: 'Jack', last_name: 'Skeleton', custom_data: {} )
author = Author.last  # -> author.full_name is available

Author.new( first_name: 'Jack', last_name: 'Fish', custom_data: {} ).save
author = Author.last
author.update_column :first_name, 'Jim'
author.update last_name: 'Cage'

author.fiscal_code = 'AaBbCc123'
author.save
author.reload
# -> author.detail.upper_fiscal_code  is available
# -> author.detail.length_fiscal_code is available (stored)
```

## MySQL tests

```sql
SELECT COUNT(*) FROM authors WHERE custom_data->"$.a_ref" = 123;
EXPLAIN SELECT COUNT(*) FROM authors WHERE custom_data->"$.a_ref" = 123;
# -> filtered: 100.00 - Using where
SELECT COUNT(*) FROM authors WHERE ref = 123;
EXPLAIN SELECT COUNT(*) FROM authors WHERE ref = 123;
# -> filtered:  33.33 - Using where; Using index
```

## Contributors

- [Mattia Roccoberton](http://blocknot.es)
