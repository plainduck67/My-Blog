    // I'm sorry guys, I don't know javascript, so I asked Ai, Everything else is me
    // I will recode when I learn how to code javascript
    const cursor = document.getElementById('customCursor');

    document.addEventListener('mousemove', e => {
      cursor.style.transform = `translate(${e.clientX}px, ${e.clientY}px)`;
    });

    document.querySelectorAll('button, a').forEach(el => {
      el.addEventListener('mouseenter', e => {
        cursor.style.transform = `translate(${e.clientX}px, ${e.clientY}px) scale(1.5)`;
      });
      el.addEventListener('mouseleave', e => {
        cursor.style.transform = `translate(${e.clientX}px, ${e.clientY}px) scale(1)`;
      });
    });