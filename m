From: ffl@aber.ac.uk (Fred Labrosse)
Date: Thu, 26 May 2005 11:12:39 +0000
Subject: [lm-sensors] External sensor and i2c/parallel adapters
Message-Id: <20050526101154.6c823e9c@localhost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

All,

I need to connect a compass having an i2c bus to a computer.  The
current plan is to use one of these i2c/parallel port adapters. 
However, I'm not sure if it will indeed work.  Here is what I think at
the moment.

Many kernel drivers do support e.g. the Philips adapters.  However, it
seems that this is not to use the adapter externally.  This would
however work with the i2c-pcf-epp driver, but it hasn't been ported yet
to linux 2.6 (I saw a more than 1 year old message on that on this list,
but no follow up).

The doc for the i2c-parport kernel module gives the schematics of a diy
"i2c-over-parallel-port" adapter.  Anybody knows how easy it is to use?

Any suggestions?

Cheers,

Fred
