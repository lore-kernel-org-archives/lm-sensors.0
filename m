From: toth_andras@chello.hu (=?ISO-8859-1?Q?T=F3th_Andr=E1s?=)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: #1353 still error!!
Message-Id: <3F2A9C60.8000203@chello.hu>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F28DE38.70801@chello.hu>
In-Reply-To: <3F28DE38.70801@chello.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>
>
>OK, three possibilities then:
>
>1* The PCI ID of your i801 chip is not in our list. Very unlikely, else
>sensors-detect wouldn't have detected it at first.
>
>2* There is another driver requesting the "authority" upon this chip.
>I've heard stories about this, I don't know if it applies there. Are
>there any other driver on your system you know of which uses the i801?
>  
>
How do I know if anything uses it? Where can I disable it?

>3* You have an Asus motherboard which hides the i2c bus. In this case,
>refer to prog/hotplug/README.p4b. I think this is the more probable, so
>you should try this first.
>  
>
I've read the README.p4b file and did exactly what it says, but it seems 
nothing has changed, it can do the "insmod p4b_smbus.o" without any 
errors, then I write those modprobe lines which are in the README then I 
start sensors but nothing has changed (sensors-detect also says: No 
sensors found).

So, I think the problem will be that in the 2. possibility, because I've 
tried lspci before doing those things written in the README and there's 
the 00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 05) line.
What should I do now?

Thank you for your kind help and patience!
Best regards,
Toth Andras

