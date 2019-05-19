(function() {
  let iframe = document.createElement('iframe');
  iframe.style.display = 'none';
  document.body.appendChild(iframe);
  const nonStandardWindowProperties = Object.keys(window)
    .filter(name => !iframe.contentWindow.hasOwnProperty(name))
    .map(
      name => Object.assign(
        {name},
        Object.getOwnPropertyDescriptor(window, name)
      )
    );
  document.body.removeChild(iframe);
  console.log(nonStandardWindowProperties);
})()
