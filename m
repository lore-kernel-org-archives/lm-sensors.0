From: morris@wolfman.com (Jim Morris)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: lm_sensors2/prog/detect sensors-detect
Message-Id: <20030627104916.BAE5.MORRIS@wolfman.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021107235845.0037e195.khali@linux-fr.org>
In-Reply-To: <20021107235845.0037e195.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Yes, I'll run more tests. I'll get this one done today.

On Fri, 27 Jun 2003 09:40:21 +0200
Jean Delvare <khali@linux-fr.org> wrote:

khali> 
khali> > Ok here are the two results snipped for ITE detection....
khali> 
khali> I guess there were similar errors (Malformed UTF-8 character) for some
khali> other chipsets?
khali> 
khali> Anyway, I'm stumped. I was expecting your system to return UTF-8 chars
khali> from /dev/ports, and it doesn't seem so (or why would perl say they are
khali> malformed?) And if it returns regular chars, why are the values
khali> different from the ones obtained with a non-UTF-8 locale?  I just don't
khali> understand.
khali> 
khali> So from here I only see two possibilities:
khali> 
khali> 1* Opening /dev/ports in binary mode solves the problem (which I doubt,
khali> since traditionally, Unix systems don't differenciate text and binary
khali> modes). Please grab the modified script that does this and tell me if it
khali> works:
khali>   http://www.ensicaen.ismra.fr/~delvare/sensors-detect-k3
khali> 
khali> 2* I just don't know what we can do. In this case, the only thing I can
khali> propose is checking for the LANG environment variable, and generate a
khali> warning at start is if matches *.UTF8, stating that the user should
khali> better restart the script with a non-UTF-8 locale. We can even change
khali> the LANG environment variable in the script, but I don't know if that
khali> would work (I don't know if Perl "reads" it at the beginning, once for
khali> all, or each time its value matters). Jim, would you accept doing some
khali> more tests for us?
khali> 
khali> Thanks.
khali> 
khali> -- 
khali> Jean Delvare
khali> http://www.ensicaen.ismra.fr/~delvare/
khali> 

--
Jim Morris morris@wolfman.com
