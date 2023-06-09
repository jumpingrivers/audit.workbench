% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/check_package.R
\name{check_cran}
\alias{check_cran}
\alias{check_quarto_beamer}
\alias{check_quarto_docx}
\alias{check_quarto_html}
\alias{check_quarto_observable}
\alias{check_quarto_pdf}
\alias{check_quarto_rsvg_convert}
\title{R6 classes}
\description{
R6 classes

R6 classes
}
\details{
Check classes
}
\section{Super classes}{
\code{\link[audit.base:logger]{audit.base::logger}} -> \code{\link[audit.base:base_check]{audit.base::base_check}} -> \code{check_cran}
}
\section{Methods}{
\subsection{Public methods}{
\itemize{
\item \href{#method-check_cran-check}{\code{check_cran$check()}}
\item \href{#method-check_cran-clone}{\code{check_cran$clone()}}
}
}
\if{html}{\out{
<details open><summary>Inherited methods</summary>
<ul>
<li><span class="pkg-link" data-pkg="audit.base" data-topic="logger" data-id="get_log"><a href='../../audit.base/html/logger.html#method-logger-get_log'><code>audit.base::logger$get_log()</code></a></span></li>
<li><span class="pkg-link" data-pkg="audit.base" data-topic="logger" data-id="start_logger"><a href='../../audit.base/html/logger.html#method-logger-start_logger'><code>audit.base::logger$start_logger()</code></a></span></li>
<li><span class="pkg-link" data-pkg="audit.base" data-topic="logger" data-id="stop_logger"><a href='../../audit.base/html/logger.html#method-logger-stop_logger'><code>audit.base::logger$stop_logger()</code></a></span></li>
<li><span class="pkg-link" data-pkg="audit.base" data-topic="base_check" data-id="info"><a href='../../audit.base/html/base_check.html#method-base_check-info'><code>audit.base::base_check$info()</code></a></span></li>
<li><span class="pkg-link" data-pkg="audit.base" data-topic="base_check" data-id="initialize"><a href='../../audit.base/html/base_check.html#method-base_check-initialize'><code>audit.base::base_check$initialize()</code></a></span></li>
</ul>
</details>
}}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-check_cran-check"></a>}}
\if{latex}{\out{\hypertarget{method-check_cran-check}{}}}
\subsection{Method \code{check()}}{
Installs a package from CRAN
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{check_cran$check(debug_level)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{debug_level}}{See check() for details}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-check_cran-clone"></a>}}
\if{latex}{\out{\hypertarget{method-check_cran-clone}{}}}
\subsection{Method \code{clone()}}{
The objects of this class are cloneable with this method.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{check_cran$clone(deep = FALSE)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{deep}}{Whether to make a deep clone.}
}
\if{html}{\out{</div>}}
}
}
}
