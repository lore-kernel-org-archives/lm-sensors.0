From: "David Boss" <spacem0nkey411@gmail.com>
Date: Wed, 22 Aug 2007 18:21:10 +0000
Subject: [lm-sensors] lm-sesors on vostro 1500 please help
Message-Id: <9cedb0eb0708221121n796e9c05w2d2ed5537df5bcfc@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6470726977121746009=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============6470726977121746009==
Content-Type: multipart/alternative; 
	boundary="----=_Part_53225_3277000.1187806870509"

------=_Part_53225_3277000.1187806870509
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

(01:01:46 PM) *saru411:* hello again...finally off of school so time to try
to get lm-sensors installed.i have run sensors-detect and have gotten
this...
(01:02:12 PM) *saru411:* # I2C adapter drivers
(01:02:12 PM) *saru411:* # modprobe unknown adapter NVIDIA i2c adapter 0 at
1:00.0
(01:02:12 PM) *saru411:* # modprobe unknown adapter NVIDIA i2c adapter 1 at
1:00.0
(01:02:12 PM) *saru411:* # modprobe unknown adapter NVIDIA i2c adapter 2 at
1:00.0
(01:02:12 PM) *saru411:* i2c-i801
(01:02:12 PM) *saru411:* # Chip drivers
(01:02:12 PM) *saru411:* eeprom
(01:02:12 PM) *saru411:* # no driver for Smart Battery Charger yet
(01:02:12 PM) *saru411:* # Warning: the required module smartbatt is not
currently installed
(01:02:12 PM) *saru411:* # on your system. For status of 2.6 kernel ports
check
(01:02:12 PM) *saru411:* # http://www.lm-sensors.org/wiki/Devices. If driver
is built
(01:02:12 PM) *saru411:* # into the kernel, or unavailable, comment out the
following line.
(01:02:12 PM) *saru411:* smartbatt
(01:03:38 PM) *saru411:* the next step is to edit /etc/rc.d/xxxx but i dont
see /rc.d .. i have rc0.d
(01:04:08 PM) *saru411:* rc1.d rc2.d rc3.d rc4.d rc5.d and rc6.d
(01:04:30 PM) *saru411:* which one am i suppose to edit and what file do i
edit in the folder

------=_Part_53225_3277000.1187806870509
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<font size="2"><font color="#204a87">(01:01:46 PM) </font></font><font color="#204a87"><b><font size="3">saru411:</font></b></font><font size="3"> hello again...finally off of school so time to try to get lm-sensors installed.i
 have run sensors-detect and have gotten this...</font><br><font size="2"><font color="#204a87">(01:02:12 PM) </font></font><font color="#204a87"><b><font size="3">saru411:</font></b></font><font size="3"> # I2C adapter drivers
</font><br><font size="2"><font color="#204a87">(01:02:12 PM) </font></font><font color="#204a87"><b><font size="3">saru411:</font></b></font><font size="3"> # modprobe unknown adapter NVIDIA i2c adapter 0 at 1:00.0</font>
<br><font size="2"><font color="#204a87">(01:02:12 PM) </font></font><font color="#204a87"><b><font size="3">saru411:</font></b></font><font size="3"> # modprobe unknown adapter NVIDIA i2c adapter 1 at 1:00.0</font><br><font size="2">
<font color="#204a87">(01:02:12 PM) </font></font><font color="#204a87"><b><font size="3">saru411:</font></b></font><font size="3"> # modprobe unknown adapter NVIDIA i2c adapter 2 at 1:00.0</font><br><font size="2"><font color="#204a87">
(01:02:12 PM) </font></font><font color="#204a87"><b><font size="3">saru411:</font></b></font><font size="3"> i2c-i801</font><br><font size="2"><font color="#204a87">(01:02:12 PM) </font></font><font color="#204a87"><b><font size="3">
saru411:</font></b></font><font size="3"> # Chip drivers</font><br><font size="2"><font color="#204a87">(01:02:12 PM) </font></font><font color="#204a87"><b><font size="3">saru411:</font></b></font><font size="3"> eeprom</font>
<br><font size="2"><font color="#204a87">(01:02:12 PM) </font></font><font color="#204a87"><b><font size="3">saru411:</font></b></font><font size="3"> # no driver for Smart Battery Charger yet</font><br><font size="2"><font color="#204a87">
(01:02:12 PM) </font></font><font color="#204a87"><b><font size="3">saru411:</font></b></font><font size="3"> # Warning: the required module smartbatt is not currently installed</font><br><font size="2"><font color="#204a87">
(01:02:12 PM) </font></font><font color="#204a87"><b><font size="3">saru411:</font></b></font><font size="3"> # on your system. For status of 2.6 kernel ports check</font><br><font size="2"><font color="#204a87">(01:02:12 PM) 
</font></font><font color="#204a87"><b><font size="3">saru411:</font></b></font><font size="3"> # <a href="http://www.lm-sensors.org/wiki/Devices">http://www.lm-sensors.org/wiki/Devices</a>. If driver is built</font><br><font size="2">
<font color="#204a87">(01:02:12 PM) </font></font><font color="#204a87"><b><font size="3">saru411:</font></b></font><font size="3"> # into the kernel, or unavailable, comment out the following line.</font><br><font size="2">
<font color="#204a87">(01:02:12 PM) </font></font><font color="#204a87"><b><font size="3">saru411:</font></b></font><font size="3"> smartbatt</font><br><font size="2"><font color="#204a87">(01:03:38 PM) </font></font><font color="#204a87">
<b><font size="3">saru411:</font></b></font><font size="3"> the next step is to edit /etc/rc.d/xxxx but i dont see /rc.d .. i have rc0.d</font><br><font size="2"><font color="#204a87">(01:04:08 PM) </font></font><font color="#204a87">
<b><font size="3">saru411:</font></b></font><font size="3"> rc1.d rc2.d rc3.d rc4.d rc5.d and rc6.d</font><br><font size="2"><font color="#204a87">(01:04:30 PM) </font></font><font color="#204a87"><b><font size="3">saru411:
</font></b></font><font size="3"> which one am i suppose to edit and what file do i edit in the folder</font>

------=_Part_53225_3277000.1187806870509--


--===============6470726977121746009==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6470726977121746009==--
