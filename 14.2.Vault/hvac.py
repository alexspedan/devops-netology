import hvac
client = hvac.Client(
    url='http://127.0.0.1:49934',
    token='aiphohTaa0eeHei'
)
 
print (client.is_authenticated())
#client.is_authenticated()
 
#client.secrets.kv.v2.configure(
#    max_versions=20,
#    mount_point='secrets',
#)
 
client.secrets.kv.v2.create_or_update_secret(
    mount_point='secrets',
    path='hvac',
    secret=dict(netology='Big secret!!!'),
)

sec=client.secrets.kv.v2.read_secret_version(
    mount_point='secrets',
    path='hvac',
)

print(sec)
