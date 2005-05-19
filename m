From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: no isaset in debian
Message-Id: <20041116235529.GB13092@bode.aurel32.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041116230249.5155437f.khali@linux-fr.org>
In-Reply-To: <20041116230249.5155437f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Nov 16, 2004 at 11:02:49PM +0100, Jean Delvare wrote:
> Hi Aurelien,
Hi!

> Looks like you don't include the isaset tool in the debian packages of
> lm_sensors. Is it intentional? This tool is useful for investigating
> problems on ISA chips or reconfiguring them when the BIOS failed to do
> it properly. It's just like i2cset but for the ISA bus. I would suggest
> that you include it.
I don't know why it is not included. Maybe isaset was added recently and
I forgot to add it to the new version? In fact, as lm-sensors is
splitted in 5 differents debian packages, I have to tell which file goes
in which package. That's why I could have forgotten one file.

Anyway, it is fixed in the version 2.8.8-5 of the package which well be 
available soon on http://incoming.debian.org until it is installed in 
the archive tomorrow evening.

Bye,
Aurelien

PS: I am not on IRC anymore as I currently only have an RTC connexion
waiting for the ADSL...

-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
