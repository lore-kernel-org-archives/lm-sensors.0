From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 29 May 2006 06:29:48 +0000
Subject: [lm-sensors] svn resync
Message-Id: <20060529082948.d5cf5873.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44621B6E.6070500@sh.cvut.cz>
In-Reply-To: <44621B6E.6070500@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Philip, Axel,

Philip Edelbrock wrote:
> OK, the tar ball is there in my home directory.  I also removed everyone 
> from the writers file at cvs.lm-sensors.nu.

Hm, this turns out to be a problem, as I am now unable to update our
website to mention the migration :( Can't we have different permissions
for the website module? If not, please restore write access for me, so
that I can update the site - I promise I won't write to the i2c and
lm_sensors2 modules ;)

Axel, please proceed with the migration. There's one extra thing I'd
like you to do if possible. All our cvs commits used to begin with the
commiter's short name inside parentheses. This was helping us identify
in the commit mail who had been doing the change. Subversion does
already include the user name in the mails it generates so this
information is now redundant. Can the names be easily removed from the
messages during the migration?

At any rate, after the migration is completed, committers must no more
include their name in commit messages - this is no more needed.

Thanks,
-- 
Jean Delvare

