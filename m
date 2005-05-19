From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: i2c/sensors patch for 2.4.21 uploaded to my server....
Message-Id: <20030715174643.5702961e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EFCF67D.9040503@realitydiluted.com>
In-Reply-To: <3EFCF67D.9040503@realitydiluted.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I changed the name, but I also uploaded the corrected patches with the
> 2.4.21 prefix. All of the other 2.4.20 patches could be renamed with
> the 2.4.21 prefix and new regeneration of the patches are unnecessary.

It looks like the 2.4.21-i2c-sensors-patch.gz is older than the other
patches. You forgot to upload the new one, didn't you?

> I also downloaded the 2.8.0 stuff and tested it out on my dual Athlon
> machine. I have uploaded the 2.8.0 patches for 2.4.21 to my ftp site
> as well. There were two modules, scx200_acb.c and scx200_i2c.c that
> did not compile. These patches have also been uploaded. The link again
> is:
> 
>      ftp://ftp.realitydiluted.com/linux/i2c

I've added this link to our download page. Some things would need to be
clarified however:

1* I saw you added calls to MOD_INC_USE_COUNT and MOD_DEC_USE_COUNT in
at least the SCx200 driver.Why that? The compatibility issue raised by
this release was caused by the use of these. Mark D. Studebaker told me
to get rid of them in all kernel drivers, what I did. So, what are we
really supposed to do? Mark, I'd like to hear you on this.

2* It isn't clear what each of your patch does. I'd appreciate a list
that says which patch changes which files, and in which way.

We now have our own patch set for i2c-2.8.0 (we don't have any for
lm_sensors-2.8.0 yet though.) I'd like you to take a look at my page
that explains in detail what the patches do and why they are necessary.
In a way, I guess we made some common work, and trying to compare what
you and I did should be interesting:

    http://www.ensicaen.ismra.fr/~delvare/devel/i2c/

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
