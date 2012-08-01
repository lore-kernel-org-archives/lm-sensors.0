From: ed in 92626 <ed92626@gmail.com>
Date: Wed, 01 Aug 2012 23:10:41 +0000
Subject: [lm-sensors] help with i2cdetect
Message-Id: <CAF+LJYhBpqcps-OYJBVPH22+GpdwfftOt+KszTYGUsKKOKNW-g@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2349220353070504637=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============2349220353070504637==
Content-Type: multipart/alternative; boundary=20cf3063dc03c64edc04c63c6932

--20cf3063dc03c64edc04c63c6932
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I am using your software for the first time.
Does it work on Fedora17, kernel 3.1.0?

When I run it, 'i2cdetect -l' I get no devices back.

When I try i2cdump 0xa8 3 I get
could not open file /dev/;i2c/168.

A8 is he address of my DIMM memory modue.

Does every i2c device need to have an entry in
/dev? I checked two machines and don't see
any i2c under /dev.

thanks if you have any info.

Ed

--20cf3063dc03c64edc04c63c6932
Content-Type: text/html; charset=ISO-8859-1

Hi,<div><br></div><div>I am using your software for the first time.</div><div>Does it work on Fedora17, kernel 3.1.0?</div><div><br></div><div>When I run it, &#39;i2cdetect -l&#39; I get no devices back.</div><div><br></div>

<div>When I try i2cdump 0xa8 3 I get</div><div>could not open file /dev/;i2c/168.</div><div><br></div><div>A8 is he address of my DIMM memory modue.</div><div><br></div><div>Does every i2c device need to have an entry in<br>

/dev? I checked two machines and don&#39;t see<br>any i2c under /dev.</div><div><br></div><div>thanks if you have any info.</div><div><br></div><div>Ed</div>

--20cf3063dc03c64edc04c63c6932--


--===============2349220353070504637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2349220353070504637==--
