From: millerlf@telus.net (lloyd)
Date: Tue, 02 May 2006 15:10:58 +0000
Subject: [lm-sensors] lm-sensors Digest, Vol 12, Issue 57
Message-Id: <44577682.1000408@telus.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

  Jean Delvare <khali at linux-fr.org> wrote | Subject: Re: [lm-sensors] 
user prog "sensors" seg faults on x86_64? |

>| > We have a dual Opteron 285 system on a Tyan Tiger K8WE (S2877) 
>| > motherboard. The make user ; make user_install went fine. The 
>| > sensor-detect script seemed to run ok and the modprobes seemed to work 
>| > but the "sensors -s" command segfaults. Is it a 64 bit problem? Using 
>| > Suse 10.1 x86_64 beta atm.
>  
>
| 
| Which version of lm_sensors is this?

2.10.0

| 
| Does "sensors" (without -s) work?

also seg faults

| 
| Why don't you use the package which comes with Suse?

also seg faults (I downloaded the package assuming it would be newer, it wasn't)

| 
| Which beta is this?

10.1 beta 9
| 
| I'm using lm_sensors on Suse 10.0 x86_64 myself for quite some time now
| without a problem, so I doubt there is a general 64-bit problem.
| 
it seems it is something in the sysfs that is causing the crash. I tried 
to build sensors with debuging but all gdb would tell me was the seg 
fault was in : Program received signal SIGSEGV, Segmentation fault. 
0x00002af197a9deaf in sensors_read_one_sysfs_chip () from 
/usr/local/lib/libsensors.so.3 I havn't got it to tell me the exact line 
where its crashing (yet).


