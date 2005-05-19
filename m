From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:03 +0000
Subject: lm_sensors2/doc version.texi
Message-Id: <20030703095204.52d9bbd4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Update of /home/cvs/lm_sensors2/doc
> In directory mordac.netroedge.com:/tmp/cvs-serv5300
> 
> Modified Files:
> 	version.texi 
> Log Message:
> (Khali) Removed revision, set version to 2.9.

Due to the order in which I commited the changes, I expect the rule to
build the HTML FAQ to be used on a freshly checked out snapshot (and
thus for the end users of the 2.8.0 release). I see three possibilities
to prevent that.

1* Keep an eye on timestamps and change them as needed. I don't know how
to do that on the other CVS end. Do I need to force a commit?

2* Edit the rules so that the FAQ files are build if and only if they do
not exist, regardless of timestamps. The better for the user, but can
eventually be a burden for us developpers.

3* Ask make to ignore failures on these commands (using a leading dash).
This will show some errors which, even if non-fatal, may confuse the
users.

I'd be in favor of solution #2 but would like to hear any opinion or
other proposal.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
