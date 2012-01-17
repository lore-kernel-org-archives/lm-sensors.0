From: Jim Duchek <jim.duchek@gmail.com>
Date: Tue, 17 Jan 2012 17:08:05 +0000
Subject: [lm-sensors] Clearing intrusion detection -- sensors(3) change or at least in the FAQ
Message-Id: <CAJWAMOYaA69E98vJjW2XHbUb+SiN425zngqKDOrxghVPtETFeA@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1439292765573039660=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============1439292765573039660==
Content-Type: multipart/alternative; boundary=90e6ba6138aee5fcc504b6bc5f82

--90e6ba6138aee5fcc504b6bc5f82
Content-Type: text/plain; charset=ISO-8859-1

Hi all.  I don't subscribe to this list so please CC any responses, thanks.

I recently had to clear my CMOS and this appears to have triggered the
intrusion detection on my motherboard.  I do like that it's not
automatically cleared like other alarms, but no way to clear it in the
BIOS, unfortunately, and I was unable to find anything in the lm_sensors
documentation or via google to help either (I certainly may have missed
it).  I dug around in the it87 module source and saw writing to the sysfs
file would clear it, so problem solved (for me).  There probably ought to
be an option in sensors(3) or at least a note in the FAQ about clearing the
intrusion alarm, though I'm not familiar enough with the innards of the
hwmon setup to do something properly generic myself.

Thanks all!
Jim

--90e6ba6138aee5fcc504b6bc5f82
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all. =A0I don&#39;t subscribe to this list so please CC any responses, t=
hanks.<div><br></div><div>I recently had to clear my CMOS and this appears =
to have triggered the intrusion detection on my motherboard. =A0I do like t=
hat it&#39;s not automatically cleared like other alarms, but no way to cle=
ar it in the BIOS, unfortunately, and I was unable to find anything in the =
lm_sensors documentation or via google to help either (I certainly may have=
 missed it). =A0I dug around in the it87 module source and saw writing to t=
he sysfs file would clear it, so problem solved (for me). =A0There probably=
 ought to be an option in sensors(3) or at least a note in the FAQ about cl=
earing the intrusion alarm, though I&#39;m not familiar enough with the inn=
ards of the hwmon setup to do something properly generic myself.</div>
<div><br></div><div>Thanks all!</div><div>Jim</div><div><br></div>

--90e6ba6138aee5fcc504b6bc5f82--


--===============1439292765573039660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1439292765573039660==--
