From: BAGSOFCHOICE@oldtolley.fsnet.co.uk (John Richard Smith)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: LM_sensors   /   Slackware9.1
Message-Id: <414C2093.40503@oldtolley.fsnet.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <414B714D.4080300@oldtolley.fsnet.co.uk>
In-Reply-To: <414B714D.4080300@oldtolley.fsnet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>>root@Root:~# sensors
>>Can't access procfs/sysfs file
>>Unable to find i2c bus information;
>>For 2.6 kernels, make sure you have mounted sysfs and done
>>'modprobe i2c_sensor'!
>>For older kernels, make sure you have done 'modprobe i2c-proc'!
>>
>>
>>My SW9.1 is not using a 2.6 kernel, so I don't know what it refers to.
>>    
>>
>
>Are you blind or what? I can hardly say more to you than I already did
>in ticket #1777. The solution is written in WHOLE LETTERS: modprobe
>i2c-proc. Is it that hard to type these words in your shell and hit the
>"Return" key?
>
root@Root:~# modprobe i3c-proc
modprobe: Can't locate module i3c-proc

John
