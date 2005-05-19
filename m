From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: Vaio eeprom security issue
Message-Id: <20030807120501.057f0c74.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030806233617.5a83d0b6.khali@linux-fr.org>
In-Reply-To: <20030806233617.5a83d0b6.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> On Wed, Aug 06, 2003 at 11:36:17PM +0200, Jean Delvare wrote:
> > 
> > 3* Define a security policy for that password issue. I think we
> > simply should disable the Vaio EEPROM in the eeprom module if we
> > find there is a password set. It could be forced using the
> > force_eeprom module parameter (or should we define another module
> > parameter?) Another possibility is to hide that particular field
> > instead, but I'm not sure it's worth the work.
> 
> How about only allowing root (or the proper CAP_* value) to read this
> value.  I imagine it would be useful for some people to get access to
> this for legimate reasons.

I'm not sure I get what you mean there (what are these CAP_* values?).

Here are my random thoughts about the problem:

1* We could add some code to eeprom_detect that determines wether this
is a Sony Vaio EEPROM, and store the result in a new variable in
eeprom_data. If this is a Sony Vaio EEPROM, we could check wether a BIOS
password is set, and store the result in another variable in
eeprom_data, or the same variable.

2* Using the variable(s) defined above, we can do one of the following:

 #1 Nothing. Leave the responsability to the person who loaded the
module. We still can document the problem in doc/chips/eeprom.

 #2 Do not support this EEPROM at all if a password is set. Document in
doc/chips/eeprom accordingly.

 #3 Do not export that particular data. Remove the corresponding /proc
entry. I expect this solution to be difficult to handle for userspace
programs such as sensors.

 #4 Export that particular data with mode 400 instead of 444. Same
problems as with the previous option for non-root users.

 #5 Export the seven bytes as 0x00 whatever their value. This is
probably the easier way for userspace programs. Tricky however.

 #6 Something else?

I'm in favor of solution #2. If the user set a password, he/she is
concerned by security, and probably don't want the EEPROM to be exported
to userspace at all (the EEPROM contains the serial number and UUID of
the machine). We still can honor the force_eeprom parameter.

Anyway, root still can run i2cdump and obtain the same information, so
this isn't the problem.

Remember that the eeprom module is a generic module, although it was
born to support SPD in the first place. I don't think we want it to
become another overcrowded module like w83781d, so adding too much
specific code, in particular for a rare and proprietary eeprom, does not
sound good.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
