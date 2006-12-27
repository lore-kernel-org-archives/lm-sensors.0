From: support@ocg.ca (Michelle Dupuis)
Date: Wed, 27 Dec 2006 00:14:33 +0000
Subject: [lm-sensors] #2143: Can't detect sensors on Asus DSBF-D
Message-Id: <001201c7294b$fc1acf90$35fe1fac@ocg.ca>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I applied the W83793 driver patch to 2.6.18 kernel, and it worked great.  My
asus dsbf-d mobo is now reading fan and temp settings.  (I get one mystery
fan reading - since nothing is plugged in there - but that's ok since I just
ignore it).

I have not made any progress getting the FB-DIMMs to decode (only the BIOS
seems able to decode the temp info).

MD 

-----Original Message-----
From: lm-sensors-notify@lm-sensors.org
[mailto:lm-sensors-notify at lm-sensors.org] 
Sent: Tuesday, December 26, 2006 6:48 PM
Cc: lm-sensors-notify at lm-sensors.org
Subject: Re: [lm-sensors] #2143: Can't detect sensors on Asus DSBF-D
motherboard

#2143: Can't detect sensors on Asus DSBF-D motherboard
-----------------------------+----------------------------------------------
  Reporter:  support at ocg.ca  |       Owner:  ruik             
      Type:  defect          |      Status:  assigned         
  Priority:  major           |   Milestone:                   
 Component:  hardware        |     Version:  2.10.1           
Resolution:                  |    Keywords:  Asus DSBF sensors
-----------------------------+----------------------------------------------
Comment (by ticket):

 There is the latest sensors-detect output, it finds it.

 That is another person "MD" that has the asus. He will have to try w83793.
 I only have the intel with ipmi.

 Also, the test program will freeze the system after 30 seconds or so if I
 use it like: "watch ./test|grep -A1 "86 80", so I won't do that :)

 I can test your driver, and find some others with FB-DIMMs on Tyan boards
 with IPMI.

 Thanks,
 Frank

-- 
Ticket URL: <http://lm-sensors.org/ticket/2143#comment:10>
lm-sensors <http://lm-sensors.org/>
Linux hardware monitoring



