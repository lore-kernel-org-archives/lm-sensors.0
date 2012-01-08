From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Sun, 08 Jan 2012 16:23:29 +0000
Subject: [lm-sensors] next 17 checkpatch patches
Message-Id: <CACW_hTZ1cYLXJS3cpsQ8fDTrr40PqPc654892a7FRR7VNng9GA@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1009671632101188843=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============1009671632101188843==
Content-Type: multipart/alternative; boundary=bcaec5395ef8cb7bcd04b606b30a

--bcaec5395ef8cb7bcd04b606b30a
Content-Type: text/plain; charset=ISO-8859-1

Hi all,

I've examined some more files for checkpatch problems.
After this I'll post 17 patches.
checkpatch lists no problems with them
They are all compile tested

Within the files I address some problems are not resolved:

There were a few places where lines were a few chars too long but were not
easy to break
(e.g. because it was a long URL).

There was one place where a macro needed a do while(0); didn't peek at that
one yet

And on a place there were two assignments in an if. Previously on a
different case Jean told me
it was intentional, therefore I did not touch it
(I did touch a few places where there was a single assignment within an if).

I might be doing a few more of these later today or next few days.
There are still about 50 files with errors or warning left. However, I have
kinda picked the low hanging fruit (= the files that only have a few
errors).

Best regards, Frans

PS: I did not bother to report the details of the checkpatch errors that
were fixed in the commit message.
For some of the files that still are to be done that would result in commit
messages of > 100 lines (and not too useful).

--bcaec5395ef8cb7bcd04b606b30a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,<br><br>I&#39;ve examined some more files for checkpatch problems.<b=
r>After this I&#39;ll post 17 patches.<br>checkpatch lists no problems with=
 them<br>They are all compile tested<br><br>Within the files I address some=
 problems are not resolved:<br>
<br>There were a few places where lines were a few chars too long but were =
not easy to break<br>(e.g. because it was a long URL).<br><br>There was one=
 place where a macro needed a do while(0); didn&#39;t peek at that one yet<=
br>
<br>And on a place there were two assignments in an if. Previously on a dif=
ferent case Jean told me<br>it was intentional, therefore I did not touch i=
t <br>(I did touch a few places where there was a single assignment within =
an if).<br>
<br>I might be doing a few more of these later today or next few days.<br>T=
here are still about 50 files with errors or warning left. However, I have =
kinda picked the low hanging fruit (=3D the files that only have a few erro=
rs).<br>
<br>Best regards, Frans<br><br>PS: I did not bother to report the details o=
f the checkpatch errors that were fixed in the commit message.<br>For some =
of the files that still are to be done that would result in commit messages=
 of &gt; 100 lines (and not too useful).<br>

--bcaec5395ef8cb7bcd04b606b30a--


--===============1009671632101188843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1009671632101188843==--
