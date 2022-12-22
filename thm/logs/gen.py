import os
import time

for i in range(0,10000) :
    os.system("/root/coin/thm/bin/thm-cli generatetoaddress 5 '16vg3LTc3HTDh8TSeEj6mmouy3o8Z2Abgk'")
    print(i)
    print(os.system("/root/coin/thm/bin/thm-cli getblockcount"))

    if i % 10 == 0 :
        print(os.system("/root/coin/thm/bin/thm-cli getbalance theheim"))

