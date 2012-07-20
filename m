From: Boussac Jean-Paul <mahimahi@laposte.net>
Date: Fri, 20 Jul 2012 07:04:51 +0000
Subject: Re: [lm-sensors] SYSTIN, CPUTIN, AUXTIN...
Message-Id: <50090313.6050801@laposte.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <911349481.542030.1342736745161.JavaMail.www@wwinf8212>
In-Reply-To: <911349481.542030.1342736745161.JavaMail.www@wwinf8212>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Le 20/07/2012 17:46, Jean Delvare a =E9crit :
> On Fri, 20 Jul 2012 05:14:26 +0200, mahimahi wrote:
>> In fact, I've two files in my /etc/sensors.d/ :
>> - ignoreFANs
>> - ignoreAUTRE
>> and in the two, I put the same first line (chip "nct6776-*")... but in "=
ignoreAUTRE",
>> there is an error :
>> Error: File /etc/sensors.d/ignoreAUTRE~, line 7: Parse error in chip name
>> I see it when I run "sensors - u"
>>
>> I replace chip "nct6776-*" by chip "nct6776-isa-0290"... and it work fine
>>
>> I don't understand why two same lines (copy/paste)... are not same !?!
> They are not. Pay attention to the exact file name reported:
> ignoreAUTRE~. The trailing ~ indicates a backup copy of the file,
> created by your text editor. "sensors -s" doesn't know it should ignore
> this file. So you must delete this backup file manually.
>
Merci beaucoup pour cette explication, je suis vraiment con - et aveugle=20
- parfois !

Thank you very much, it's a fine explanation, i'm a guy sometime...

Jean-Paul BOUSSAC


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
