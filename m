From: DB <Freddog_de@yahoo.co.uk>
Date: Tue, 04 Jan 2011 10:45:57 +0000
Subject: Re: [lm-sensors] Problem making lmsensors
Message-Id: <4D22FA65.7010802@yahoo.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D224799.4050300@yahoo.co.uk>
In-Reply-To: <4D224799.4050300@yahoo.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 01/03/2011 11:11 PM, Guenter Roeck wrote:
> Did you run make clean after installing flex and bison ?
>
>
Hi Guenter,

No, I didn't try make clean last night.  I've just tried it now & cannot 
find anyway to make it work!  Not even a man page....
  Here are my results:

[Dave@Fedora-Blue LM-Sensors]$ make clean
make: *** No rule to make target `clean'.  Stop.
[Dave@Fedora-Blue LM-Sensors]$ su
Password:
[root@Fedora-Blue LM-Sensors]# makeclean
bash: makeclean: command not found
[root@Fedora-Blue LM-Sensors]# make clean
make: *** No rule to make target `clean'.  Stop.

Seems like noone/notheing wants to do that!

Thanks

Dave

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
