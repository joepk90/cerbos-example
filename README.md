# Cerbos Example
A basic service demonstrating Cerbos Policies in action.


## Example Usage
Start the service (build the image first if neccesary)
```
make docker-run
```

### Failing Curl Request (Role = User)

<b>Request:</b>
```
curl -X POST http://localhost:3592/api/check/resources \
  -H "Content-Type: application/json" \
  -d @- <<'EOF'
{
  "principal": { "id": "email@email.com", "roles": ["user"] },
  "resources": [ 
    {
        "resource": { "kind": "post", "id": "*" },
        "actions": ["update"]
    }
   ]
}
EOF
```

<b>Response:</b>
```
{"results":[{"resource":{"id":"*", "kind":"post"}, "actions":{"update":"EFFECT_DENY"}}], "cerbosCallId":"XXXXXXXXXXXXX"}%  
```

### Successful Curl Request (Role = Admin)

<b>Request:</b>
```
curl -X POST http://localhost:3592/api/check/resources \
  -H "Content-Type: application/json" \
  -d @- <<'EOF'
{
  "principal": { "id": "email@email.com", "roles": ["admin"] },
  "resources": [ 
    {
        "resource": { "kind": "post", "id": "*" },
        "actions": ["update"]
    }
   ]
}
EOF
```

<b>Response:</b>
```
{"results":[{"resource":{"id":"*", "kind":"post"}, "actions":{"update":"EFFECT_ALLOW"}}], "cerbosCallId":"XXXXXXXXXXXXX"}%  
```

## Notes On Required Values
- The principle ID should be users email retrieved from the `sub` of a JWT token.
- The resource ID should the ID of the resource (from the external service making the request).