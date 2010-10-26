From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 26 Oct 2010 12:38:01 +0000
Subject: Re: [lm-sensors] k10temp is detected but not shown
Message-Id: <20101026143801.2de9fc24@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <578838.74607.qm@web111714.mail.gq1.yahoo.com>
In-Reply-To: <578838.74607.qm@web111714.mail.gq1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 26 Oct 2010 04:57:25 -0700 (PDT), Mahmood Naderan wrote:
> > Please attach the contents of /proc/cpuinfo and the output of lspci.
> I have attached them

Please use plain text, uncompressed attachments next time. It's easier
to watch directly in my e-mail client.

From lspci:

00:18.3 Host bridge: Advanced Micro Devices [AMD] K10 [Opteron, Athlon64, Sempron] Miscellaneous Control
00:19.3 Host bridge: Advanced Micro Devices [AMD] K10 [Opteron, Athlon64, Sempron] Miscellaneous Control
00:1a.3 Host bridge: Advanced Micro Devices [AMD] K10 [Opteron, Athlon64, Sempron] Miscellaneous Control
00:1b.3 Host bridge: Advanced Micro Devices [AMD] K10 [Opteron, Athlon64, Sempron] Miscellaneous Control

These are the PCI devices which provide temperature readings. 4 devices
-> 4 entries in "sensors", everything is as expected.

All entries in cpuinfo look the same, so I can't explain why some have
the critical limit and some don't. Please provide the output of:

lspci -xxx -d 1022:1203

> >Doh. You are aware that Core i7 CPUs are made by Intel and Family 10h
> >(aka K10) CPUs are made by AMD, aren't you? They are different CPU
> >models, they don't have to be designed the same way.
> I know that :)
> I thought maybe that is a standard and each cpu temperature must be shown 
> separetly.

There is no such standard.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
