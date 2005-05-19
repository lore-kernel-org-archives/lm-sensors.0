From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: lm_sensors2/lib data.c
Message-Id: <20030630161630.10a0799a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Update of /home/cvs/lm_sensors2/lib
> In directory mordac.netroedge.com:/tmp/cvs-serv17424
> 
> Modified Files:
> 	data.c 
> Log Message:
> (Khali) Better warning removal (less code change).
> 

For information, I just undid my previous fix (which I think would have
been working though) and used the recommended way instead, as read on
http://gcc.gnu.org/gcc-3.0/caveats.html.

Quoting:
"The undocumented extension that allowed C programs to have a label at
the end of a compound statement has been deprecated and may be removed
in a future version. Programs that now generate a warning about this may
be fixed by adding a null statement (a single semicolon) after the
label."

I first tried to have CVS understand that the new fix was to be applied
to the previous, not current, version of the file, but I failed. I in
fact don't know if it is possible. So I finally commited it normally, I
hope I didn't break anything.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
