# Cerbos Example
A basic service demonstrating Cerbos Policies in action.


## Example Usage
Start the service (build the image first if neccesary)
```
make docker-run
```

### Failing Curl Request (Role = User)
```
curl -X POST http://localhost:3592/api/check/resources \
  -H "Content-Type: application/json" \
  -d @- <<'EOF'
{
  "principal": { "id": "user-1", "roles": ["admin"] },
  "resources": [ 
    {
        "resource": { "kind": "post", "id": "post-1" },
        "actions": ["update"]
    }
   ]
}
EOF
```


### Successful Curl Request (Role = Admin)
```
curl -X POST http://localhost:3592/api/check/resources \
  -H "Content-Type: application/json" \
  -d @- <<'EOF'
{
  "principal": { "id": "user-1", "roles": ["admin"] },
  "resources": [ 
    {
        "resource": { "kind": "post", "id": "post-1" },
        "actions": ["update"]
    }
   ]
}
EOF
```