rule transfer:
    input:
        "genotyped/all.vcf.gz"
    output:
        "/root/out/all.vcf.gz"
    params:
        port=config["tranfer"]["port"]
        username=config["tranfer"]["user"]
        server=
    schell:
        "scp -p {port} {input} {username}@{server}:{output}"