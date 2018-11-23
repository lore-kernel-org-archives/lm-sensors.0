From: =?UTF-8?Q?Ond=c5=99ej_Lyson=c4=9bk?= <olysonek@redhat.com>
Date: Fri, 23 Nov 2018 15:20:30 +0000
Subject: Re: github , lm-sensors tag release
Message-Id: <9229b18d-fe7a-3e73-706d-d3ffba3cd8ef@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5BF81448.2060108@safe.ca>
In-Reply-To: <5BF81448.2060108@safe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi,

On 23. 11. 18 15:52, Jean-Marc Pigeon wrote:
> Hello,
> 
> Working to use the last lm-sensors stable version
> from github, to be use within LFS (Linux from scratch
> project).
> 
> Seen the last tag is v3-4-0, 3 year old.
> 
> Is there another way to git-archive the last stable
> version?

Well, you can use e.g. the following to archive the master branch. The
master branch should be fine to use. Is that what you're asking?
git archive --prefix lm-sensors-3.4.1/ -o lm-sensors-3.4.1.tar.gz master

> 
> How do you tag version, such everybody is on the
> same page when speaking about lm-sensors release?
> 

The next release, 3.5.0, is coming soon and it will be tagged as V3-5-0
in git.

Best regards
Ondřej Lysoněk
