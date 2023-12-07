create database testydb;

use testydb;

create table testytable (
    id int,
    name varchar(255),
    primary key (id)
);

insert into testytable (id, name) values (1, 'testy1');

insert into testytable (id, name) values (2, 'testy2');

insert into testytable (id, name) values (3, 'testy3');
