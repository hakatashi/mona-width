require! {
  fs
  tar
  zlib
  path
  request
}

IPA_MONAFONT_URL = 'http://www.geocities.jp/ipa_mona/opfc-ModuleHP-1.1.1_withIPAMonaFonts-1.0.8.tar.gz'

downloader = request IPA_MONAFONT_URL
gunzipper = new zlib.Gunzip!
parser = tar.Parse!

console.log 'Downloading font...'
downloader.pipe gunzipper .pipe parser

entry <- parser.on \entry

filename = entry.path |> path.basename

if filename is \ipagp-mona.ttf
  writer = fs.create-write-stream filename

  console.log 'Writing ipagp-mona.ttf out...'
  entry.pipe writer

  <- entry.on \end
  console.log 'Writing font file done!'
