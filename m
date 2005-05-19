From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: Super-IO
Message-Id: <20040301231157.2f85e99c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040229094305.202636c1.khali@linux-fr.org>
In-Reply-To: <20040229094305.202636c1.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

More on SuperIO chips in sensors-detect...

According to the various datasheets I read today, and the PNP ISA spec,
it looks like the following parameters are common to all Super IO chips:
	addrreg => 0x2e,
	datareg => 0x2f,
	devidreg => 0x20,
	logdevreg => 0x07,
	actreg => 0x30,
	actmask => 0x01,
	basereg => 0x60,
which would shrink the chip definitions to the following values:
	name => "ITE 8702F Super IO Sensors",
	driver => "to-be-written",
	enter => [0x87, 0x01, 0x55, 0x55],
	devid => 0x8702,
	logdev => 0x04,
	exitseq => [0x2e, 0x02, 0x2f, 0x02, 0x2e, 0xaa],
The rest being hard-coded.

About the enter sequence: Looks like Nat'l chips don't have one. Can
anyone confirm? Looks strange to me.

About the exit sequence: I now tend to think that we have to
differenciate between the "0x2e, 0xaa" sequence, which is actually the
exit counterpart of the entering sequence for some chips (not all), and
the "0x2e, 0x02, 0x2f, 0x02" sequence, which is the a kind of state
reset, and should be applied to all chips according to the PNP ISA spec.
So I think that the first one should be part of the chip definition and
applied only in case of success, while the second should hard-coded and
always applied *after* any chip-specific exit sequence (contrary to was
is done now, shame on me).

About the logical devices: Some chips (Nat'l) do have more than one
logical device of interest for us. I don't know how we want to handle
them. Ideas welcome.

About the base address: Some chips do have a secondary address. The
current code doesn't handle it. I guess that we can check it (if the
primary address wasn't 0) and print it if and if only it isn't 0.

About the device id: Some chips have more than the one standard ID
register (0x20). Additional info was seen at 0x21 and 0x27, but this
isn't standard. I think that we should express the identifier as a list
of address, value couples (so the devidreg value would in fact be part
of the chip definition). Or even as address, mask, value triplets, to
cover all cases. I need to think a bit more about it though.

About the activity register: SMSC chips had it set to 0x20 in
sensors-detect so far, but I couldn't see anything of that nature in the
datasheets. I think it was a typo and the correct value is 0x30, as seen
everywhere else and written in the PNP ISA spec.

I think it's all...

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
