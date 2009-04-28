From: Didier Roche <didrocks@ubuntu.com>
Date: Tue, 28 Apr 2009 13:00:50 +0000
Subject: Re: [lm-sensors] Please,
Message-Id: <fe6167c00904280600p6983b487g3e061b88941909c8@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <fe6167c00904270421g19534018n7d544427e675d412@mail.gmail.com>
In-Reply-To: <fe6167c00904270421g19534018n7d544427e675d412@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, Apr 28, 2009 at 1:57 PM, Andre Prendel <andre_prendel@gmx.de> wrote:
> On Mon, Apr 27, 2009 at 01:21:58PM +0200, Didier Roche wrote:
>> Hi lm-sensors developer,
>>
>> It would be great if lm-sensors can take into account distribution
>> LDFLAGS so that exported variables change linker behavior.
>>
>> For instance, ubuntu uses -Wl,-Bsymbolic-functions. Taking this patch
>> will enable us to just sync from debian on this package.
>>
>> In Ubuntu, we've applied the attached patch to achieve the following:
>>
>> =A0 * handle default ubuntu LDFLAGS for linking option (LP: #321632)
>> =A0 =A0 - Remove the old hack directly pushed in lib/Module.mk (now
>> =A0 =A0 =A0 lib/Module.mk if from pristine source)
>> =A0 =A0 - add debian/patches/07-use-LDFLAGS.patch to take LDFLAGS into a=
ccount
>>
>> Debian and Ubuntu thought you might be interested to handle this
>> directly upstream.
>>
>>
>> --- lm-sensors-3-3.0.2.orig/lib/Module.mk =A0 =A0 =A02008-05-18
>> 8:07:48.000000000 +0200
>> +++ lm-sensors-3-3.0.2/lib/Module.mk =A0 2009-01-26 22:15:02.000000000 +=
0100
>> @@ -60,7 +60,7 @@
>>
>> =A0# How to create the shared library
>> =A0$(MODULE_DIR)/$(LIBSHLIBNAME): $(LIBSHOBJECTS)
>> - =A0 =A0 =A0$(CC) -shared -Wl,-soname,$(LIBSHSONAME) -o $@ $^ -lc -lm
>> + =A0 =A0 =A0$(CC) -shared $(LDFLAGS) -Wl,-soname,$(LIBSHSONAME) -o $@ $=
^ -lc -lm
>>
>> =A0$(MODULE_DIR)/$(LIBSHSONAME): $(MODULE_DIR)/$(LIBSHLIBNAME)
>> =A0 =A0 =A0 =A0$(RM) $@
>>
>>
>> Thanks in advance. Please CC me as I'm not subscribed to the mailing lis=
t.
>> Didier
>>
>> Ubuntu bug: https://bugs.edge.launchpad.net/debian/+source/lm-sensors-3/=
+bug/321632
>> Debian bug: http://bugs.debian.org/cgi-bin/bugreport.cgi?bugQ3171
>>
>
> Applied, thanks.

Thanks to YOU :)
It's a pleasure to work with a responsive upstream!

Didier

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
