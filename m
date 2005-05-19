From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:11 +0000
Subject: Vaio eeprom security issue
Message-Id: <20030809091717.324c8dfa.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030806233617.5a83d0b6.khali@linux-fr.org>
In-Reply-To: <20030806233617.5a83d0b6.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > I'm not sure I get what you mean there (what are these CAP_*
> > values?).
> 
> Different capability permission values.  Look in
> include/linux/capability.h for more information.  It's more fine
> grained than just "root".
> 
> Hope this helps,

Not really. Looks complicated ;) and it seems these are capabilities you
give to a user/process, not to a file. I just don't want to dive into
this for something that "simple".

Remember, the eeprom module, although widely used, is one of our least
interesting drivers. And LM Sensors is useless on Sony Vaio's anyway (no
sensor chips). So let's play it safe, but without extra technologies
involved. Do not export the eeproms detected as Vaio's ones unless
forced too. I'll implement that this afternoon, test it on my laptop and
commit.


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
