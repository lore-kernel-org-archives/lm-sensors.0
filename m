From: delvare@ensicaen.ismra.fr (Jean Delvare)
Date: Thu, 19 May 2005 06:23:53 +0000
Subject: IBM Thinkpad issue
Message-Id: <20030414205658.2451ac9a.delvare@ensicaen.ismra.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Salut!

Hallo!

> On
> http://secure.netroedge.com/~lm78/author.html
> you are named as the responsible developer for IBM Thinkpad problems
> of lm_sensors. I have downloaded lm_sensors-2.7.0 and readme.thinkpad
> seems to not have been updated.

What do you think should be updated?

How could you write to me at this address whereas the webpage mentioned
above specifies another one?

> Is there any safe way to use hardware monitoring on my laptop? I have
> a Thinkpad R31 with a 1.2 GHz MobileCeleron. Will I still be able to
> fry my machine with lm_sensors? Or can I safely try it?

Well, lm_sensors will hopefuly refuse to run on your system (that's how
we want things to be), even though we are pretty sure there's nothing
that could be broken on recent Thinkpads. Anyway, as far as I know,
Thinkpads don't have any supported hardware, so lm_sensors is of no
interest for them. You'll probably get better results using ACPI to get
some information about temperatures and fan status.

If you want to give it a try however, please let me know how it goes. If
you find something I ignore, I'll try to help, and will also update our
documentation about the issue.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
