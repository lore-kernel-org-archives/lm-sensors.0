From: erek@necrotec.com (erek)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: EP-9NDA3+ w/ Winbond W83627THF LPC
Message-Id: <32906.216.9.170.171.1103272080.spork@webmail.necrotec.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

i have a nForce3 250GB Ultra motherboard "EPoX EP-9NDA3+" that has the
"Winbond W83627THF LPC" chip...

but some odd reason i can't get it to work..

localhost erek # modprobe w83627hf
FATAL: Error inserting w83627hf
(/lib/modules/2.6.8.1/kernel/drivers/i2c/chips/w83627hf.ko): No such
device
localhost erek #


i don't understand what's wrong?
