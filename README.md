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

### Successful Derived Role Curl Request (Role = Owner)

<b>Request:</b>

Because the `principle.id` matches the `resource.attr.ownerId`, the derived role of `owner` is applied giving the user `edit` access.

```
curl -X POST http://localhost:3592/api/check/resources \
  -H "Content-Type: application/json" \
  -d @- <<'EOF'
{
  "principal": { "id": "1", "roles": ["user"] },
  "resources": [ 
    {
        "resource": { "kind": "post", "id": "1", "attr": { "ownerId": "1" } },
        "actions": ["edit"]
    }
   ],
   "includeMeta": true
}
EOF
```

<b>Response:</b>
```
{"results":[{"resource":{"id":"*", "kind":"post"}, "actions":{"update":"EFFECT_ALLOW"}}], "cerbosCallId":"XXXXXXXXXXXXX"}%  


## Notes On Required Values
- The principle ID should be users id retrieved from the `sub` of a JWT token.
- The resource ID should the ID of the resource (from the external service making the request).