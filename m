From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <20040204215408.3cf380da.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > > 1* Clean up sensors code so that it doesn't reference fan_min. For
> > > one thing, it'll let us get rid of the errors you had when running
> > > "sensors". (...)
> 
> I'll do this, as mentioned above.

Done and commited to CVS. Please checkout and test. Output with 2.4
driver should be unchanged, and output with 2.6 driver should now be
fine now.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
