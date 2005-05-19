From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:53 +0000
Subject: lm-sensors support for ASUS chip ASB100 Bach
Message-Id: <20030410135341.2ad40aa7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <795E03B0F1E26C449762C0EDF5F5659140F50F@Exchange.16.172.in-addr.arpa>
In-Reply-To: <795E03B0F1E26C449762C0EDF5F5659140F50F@Exchange.16.172.in-addr.arpa>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


(Consider this a pre-answer, since I'm not able to answer everything on
my own.)

> I would need some guidance from your experts.

I am no expert at all, may I try answering anyway? ;)

> I have here a Linux Server with INTEL board P4B533 with the ASUS
> ASB100-A Bach chip on board.
> I also have the configuration register specification from ASUS of the
> ASB100 ASUS ASIC under confidential NDA.
> I am supposed to solve the deficiencies and problems of the lm-sensor
> driver with the chip.

Well, ASB100 is supposed to be detected and handled by our driver
already, but we could never obtain a datasheet, so the support is BETA.

> I have studied a lot of the documents on your web site and I have the
> impression that the job is to big for me alone. I am mainly busy with
> "C-program" diagnostic tools under good old DOS. But I can imagine
> that we somehow could cooperate in order to get the thing fixed.

Sure. The first thing I'd like to know is what in our driver isn't
working for you right now? We can't fix anything unless we know what's
broken.

> I could modify either the "lm78.c" source or the "w83781d.c" source
> whichever would be more appropriate and comment and mark it properly.

The Asus ASB100 is seen as a modified AS99127, which itself is handled
by our W83781D driver. So, the file to modify is definitely "w83781d.c".
On the other hand, since the drivers are actually incorporated into the
Linux 2.5 kernel tree, working on them these days may be tricky. But if
we can make things work better, even on "temporary code", it won't be
lost.

> Additionally I assume I would have to modify the sensors.conf file
> according to vendor specification.

That's the easy part.

> Alternatively I could generate a list of chip features with functions
> and address offsets and command code. With the latter alternative I am
> unsure with regard to the legal aspects. What do you think?

I'm no law specialist, for sure. From a technical point of view, it
seems to me that it would be far easier if we could get access to the
whole information. But I don't know if we (the LM Sensors dev team) are
supposed to accept signing NDAs or not.

To be continued... (hopefully)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
