From: ffl@aber.ac.uk (Fred Labrosse)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: Reading a compass CMPS03
Message-Id: <16498.25133.562134.471157@aber.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <16497.19215.209434.328945@aber.ac.uk>
In-Reply-To: <16497.19215.209434.328945@aber.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark Studebaker writes:
 > What value of pullup resistor are you using?
 > 5K is probably about right. Definitely not less than 1K.
 > I note that doc/i2c-pport doesn't make a recommendation.
 > 

Well it actually says: "no pullups requied" (sic), which I believed because
of the resistor on the "out pin" on the diagram in the same file.
Moreover, a pullup resistor would make it even harder for the device to
pull down the signal, which seems to be what causes the noack problem.
Right?

Cheers,

Fred
