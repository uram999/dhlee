#!/bin/sh
find ./ -type f -readable -writable -exec sed -i "s/thm/thm/g" {} ";"
find ./ -type f -readable -writable -exec sed -i "s/THM/THM/g" {} ";"
find ./ -type f -readable -writable -exec sed -i "s/Thm/Thm/g" {} ";"
find ./ -type f -readable -writable -exec sed -i "s/THM/THM/g" {} ";"
find ./ -type f -readable -writable -exec sed -i "s/thmd/thmd/g" {} ";"

find ./ -type f -readable -writable -exec sed -i "s/THM/THM/g" {}  ";"
find ./ -type f -readable -writable -exec sed -i "s/thm/thm/g" {}  ";"

