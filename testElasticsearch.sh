#!/usr/bin/env bats
# Test Elasticsearch

# Global Vars
VAR="catalog/users"

get_node_name() {
    local node_name=$(curl -X GET -H "Content-Type: application/json" "http://localhost:9200/" 2>/dev/null|jq -r ".name")
    echo $node_name
}

insert() {
  # Insert data
  for i in $(seq 1 10); do
    OUT=$(curl -X PUT -H "Content-Type: application/json" \
      "http://localhost:9200/$VAR/$i" \
      -d '{ "name": "roberto", "id": 1 }' 2>/dev/null )
  done
}

implicit_insert() {
  # Insert data
  for i in $(seq 1 10); do
    OUT=$(curl -X POST -H "Content-Type: application/json" \
      "http://localhost:9200/$VAR/" \
      -d '{ "name": "roberto", "id": "'$i'" }' 2>/dev/null )
  done
}

# get() {
#   # Read data
#   curl -X GET -H "Content-Type: application/json" \
#     "localhost:9200/$VAR/1?pretty"
#   echo
#   echo
# }

search() {
  local N=$(curl -X POST -H "Content-Type: application/json" \
    "localhost:9200/$VAR/_search?pretty" 2>/dev/null|jq -r ".hits.total.value")
  echo "$N"
}

delete() {
  # Delete data
  OUT=$(curl -X DELETE "localhost:9200/*" 2>/dev/null )
  echo
  echo
}

@test "Check Node Name" {
  node_name=$(get_node_name)
  [ "$node_name" = "myNode1" ]
}

@test "Insert and Read 10 items" {
 delete
 sleep 1
 insert
 sleep 1
 N=$(search)
 echo "post insert: " $N
 [ "$N" = "10" ]
}

@test "Delete all" {
 delete
 sleep 1
 N=$(search)
 [ "$N" = "null" ]
}

@test "Implicit Insert and Read 10 items" {
 implicit_insert
 sleep 1
 N=$(search)
 echo "post insert: " $N
 [ "$N" = "10" ]
}
