From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: sensord 2.8.2 on 2.6.0/ASUS chip - subclient problem
Message-Id: <400DEEFA.5070600@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200401111319.18817.arvidjaar@mail.ru>
In-Reply-To: <200401111319.18817.arvidjaar@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I think you misunderstood me.
Checking for "subclient" should provide this information.
And checking only for a space may work now but could break later.
So please look for a "subclient" substring.
thanks
mds

Andrey Borzenkov wrote:
> On Wednesday 14 January 2004 05:32, Mark Studebaker wrote:
> 
>>The names of clients and the addresses of their subclients are "well known"
>>so in prog/sensors/main.c we just look for them (see that file for more
>>info). Your proposal to look for the string "subclient" will work equally
>>well. Feel free to submit a sensord patch to us using either technique.
> 
> 
> If I understood you correctly (subclient does not provide this information) 
> here is patch. It simply ignores any chip that has a space in name. To my 
> best knowledge every chip has single name without spaces except for special 
> case of subclients (at least that what I have done in my kernel patch). If 
> this is not true any more - tell so and I change it to look for "subclient" 
> substring.
> 
> regards
> 
> -andrey
> 
> 
>>mds
>>
>>Greg KH wrote:
>>
>>>On Sun, Jan 11, 2004 at 01:19:18PM +0300, Andrey Borzenkov wrote:
>>>
>>>>I do not know if it is a sensord (should not attempt to read subclient)
>>>>or kernel (does not provide sufficient information) problem. Subclient
>>>>can be determined by its name:
>>>>
>>>>{pts/1}% for i in /sys/bus/i2c/devices/*
>>>>do
>>>>echo ${i:t}:$(<$i/name)
>>>>done
>>>>0-002d:as99127f
>>>>0-0048:as99127f subclient
>>>>0-0049:as99127f subclient
>>>>
>>>>Greg, this is supposed to be established convention now?
>>>
>>>I think so, yes.  I'll let the userspace people answer your other
>>>questions.
>>>
>>>thanks,
>>>
>>>greg k-h
>>>
>>>
>>>------------------------------------------------------------------------
>>>
>>>--- lm_sensors-2.8.2/lib/proc.c.subclient	2003-11-29 20:44:30.000000000 +0300
>>>+++ lm_sensors-2.8.2/lib/proc.c	2004-01-18 00:03:51.095435776 +0300
>>>@@ -123,8 +123,15 @@
>>> 
>>> 		if ((f = fopen(n, "r")) != NULL) {
>>> 			char	x[120];
>>>-			fscanf(f, "%[a-zA-z0-9_]", x);
>>>+
>>>+			/* skip "name subclient" */
>>>+			fgets(x, sizeof(x), f);
>>> 			fclose(f);
>>>+			if (strchr(x, ' '))
>>>+				continue;
>>>+
>>>+			if (strlen(x) && x[strlen(x)-1] = '\n')
>>>+				x[strlen(x)-1] = '\0';
>>> 			/* HACK */ strcat(x, "-*");
>>> 			if ((res = sensors_parse_chip_name(x, &entry.name))) {
>>> 				char	em[NAME_MAX + 20];
