// JavaScript code to add messages dynamically
const messagesDiv = document.getElementById('messagesDiv');

function addSentMessage(message, userImage) {
    const sentDiv = document.createElement('div');
    sentDiv.classList.add('sent');
    const sentDivImg = document.createElement('div');
    sentDivImg.classList.add('sentImg');

    sentDiv.innerHTML = message;
    sentDivImg.setAttribute("src", `${userImage}`);
    
    messagesDiv.appendChild(sentDiv);
    messagesDiv.appendChild(sentDivImg);

    messagesDiv.scrollTop = messagesDiv.scrollHeight;
}

function addReceivedMessage(message, userImage) {
    const receivedDiv = document.createElement('div');
    receivedDiv.classList.add('received');
    const receivedDivImg = document.createElement('div');
    receivedDivImg.classList.add('receivedImg');

    receivedDiv.innerHTML = message;
    receivedDivImg.setAttribute("src", `${userImage}`);
    
    messagesDiv.appendChild(receivedDiv);
    messagesDiv.appendChild(receivedDivImg);
    
    messagesDiv.scrollTop = messagesDiv.scrollHeight;
}

// Example usage:
addSentMessage("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Sit amet consectetur adipiscing elit pellentesque habitant morbi tristique senectus. Odio ut sem nulla pharetra diam sit. Aliquam id diam maecenas ultricies mi eget mauris pharetra et. Ullamcorper dignissim cras tincidunt lobortis. Sed tempus urna et pharetra pharetra massa massa ultricies. Pretium lectus quam id leo in vitae turpis massa. Diam in arcu cursus euismod quis viverra nibh. Varius duis at consectetur lorem. Pharetra magna ac placerat vestibulum lectus mauris ultrices eros. Tincidunt eget nullam non nisi. Sit amet nisl purus in mollis nunc sed. Pellentesque dignissim enim sit amet venenatis urna cursus eget. Leo vel fringilla est ullamcorper eget nulla facilisi etiam. Nisl rhoncus mattis rhoncus urna neque viverra justo. Ipsum consequat nisl vel pretium lectus quam. Faucibus et molestie ac feugiat sed. Ullamcorper eget nulla facilisi etiam dignissim. Malesuada fames ac turpis egestas."
, "/images/k.png");
addReceivedMessage("Pellentesque habitant morbi tristique senectus et. Volutpat ac tincidunt vitae semper quis lectus nulla. Vestibulum rhoncus est pellentesque elit ullamcorper dignissim cras tincidunt lobortis. Diam vel quam elementum pulvinar etiam non quam lacus. Eget nullam non nisi est sit. Turpis nunc eget lorem dolor sed viverra ipsum nunc aliquet. Pretium viverra suspendisse potenti nullam ac tortor. Maecenas ultricies mi eget mauris pharetra et. Massa vitae tortor condimentum lacinia. Id leo in vitae turpis massa sed. Commodo nulla facilisi nullam vehicula. Duis at consectetur lorem donec massa sapien faucibus et. Volutpat sed cras ornare arcu dui vivamus arcu felis. Suscipit tellus mauris a diam maecenas sed enim ut sem. Netus et malesuada fames ac turpis egestas maecenas pharetra."
, "/images/j.jpg");
addSentMessage("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Sit amet consectetur adipiscing elit pellentesque habitant morbi tristique senectus. Odio ut sem nulla pharetra diam sit. Aliquam id diam maecenas ultricies mi eget mauris pharetra et. Ullamcorper dignissim cras tincidunt lobortis. Sed tempus urna et pharetra pharetra massa massa ultricies. Pretium lectus quam id leo in vitae turpis massa. Diam in arcu cursus euismod quis viverra nibh. Varius duis at consectetur lorem. Pharetra magna ac placerat vestibulum lectus mauris ultrices eros. Tincidunt eget nullam non nisi. Sit amet nisl purus in mollis nunc sed. Pellentesque dignissim enim sit amet venenatis urna cursus eget. Leo vel fringilla est ullamcorper eget nulla facilisi etiam. Nisl rhoncus mattis rhoncus urna neque viverra justo. Ipsum consequat nisl vel pretium lectus quam. Faucibus et molestie ac feugiat sed. Ullamcorper eget nulla facilisi etiam dignissim. Malesuada fames ac turpis egestas."
, "/images/k.png");
addReceivedMessage("Pellentesque habitant morbi tristique senectus et. Volutpat ac tincidunt vitae semper quis lectus nulla. Vestibulum rhoncus est pellentesque elit ullamcorper dignissim cras tincidunt lobortis. Diam vel quam elementum pulvinar etiam non quam lacus. Eget nullam non nisi est sit. Turpis nunc eget lorem dolor sed viverra ipsum nunc aliquet. Pretium viverra suspendisse potenti nullam ac tortor. Maecenas ultricies mi eget mauris pharetra et. Massa vitae tortor condimentum lacinia. Id leo in vitae turpis massa sed. Commodo nulla facilisi nullam vehicula. Duis at consectetur lorem donec massa sapien faucibus et. Volutpat sed cras ornare arcu dui vivamus arcu felis. Suscipit tellus mauris a diam maecenas sed enim ut sem. Netus et malesuada fames ac turpis egestas maecenas pharetra."
, "/images/j.jpg");
addSentMessage("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Sit amet consectetur adipiscing elit pellentesque habitant morbi tristique senectus. Odio ut sem nulla pharetra diam sit. Aliquam id diam maecenas ultricies mi eget mauris pharetra et. Ullamcorper dignissim cras tincidunt lobortis. Sed tempus urna et pharetra pharetra massa massa ultricies. Pretium lectus quam id leo in vitae turpis massa. Diam in arcu cursus euismod quis viverra nibh. Varius duis at consectetur lorem. Pharetra magna ac placerat vestibulum lectus mauris ultrices eros. Tincidunt eget nullam non nisi. Sit amet nisl purus in mollis nunc sed. Pellentesque dignissim enim sit amet venenatis urna cursus eget. Leo vel fringilla est ullamcorper eget nulla facilisi etiam. Nisl rhoncus mattis rhoncus urna neque viverra justo. Ipsum consequat nisl vel pretium lectus quam. Faucibus et molestie ac feugiat sed. Ullamcorper eget nulla facilisi etiam dignissim. Malesuada fames ac turpis egestas."
, "/images/k.png");
addReceivedMessage("Pellentesque habitant morbi tristique senectus et. Volutpat ac tincidunt vitae semper quis lectus nulla. Vestibulum rhoncus est pellentesque elit ullamcorper dignissim cras tincidunt lobortis. Diam vel quam elementum pulvinar etiam non quam lacus. Eget nullam non nisi est sit. Turpis nunc eget lorem dolor sed viverra ipsum nunc aliquet. Pretium viverra suspendisse potenti nullam ac tortor. Maecenas ultricies mi eget mauris pharetra et. Massa vitae tortor condimentum lacinia. Id leo in vitae turpis massa sed. Commodo nulla facilisi nullam vehicula. Duis at consectetur lorem donec massa sapien faucibus et. Volutpat sed cras ornare arcu dui vivamus arcu felis. Suscipit tellus mauris a diam maecenas sed enim ut sem. Netus et malesuada fames ac turpis egestas maecenas pharetra."
, "/images/j.jpg");
addSentMessage("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Sit amet consectetur adipiscing elit pellentesque habitant morbi tristique senectus. Odio ut sem nulla pharetra diam sit. Aliquam id diam maecenas ultricies mi eget mauris pharetra et. Ullamcorper dignissim cras tincidunt lobortis. Sed tempus urna et pharetra pharetra massa massa ultricies. Pretium lectus quam id leo in vitae turpis massa. Diam in arcu cursus euismod quis viverra nibh. Varius duis at consectetur lorem. Pharetra magna ac placerat vestibulum lectus mauris ultrices eros. Tincidunt eget nullam non nisi. Sit amet nisl purus in mollis nunc sed. Pellentesque dignissim enim sit amet venenatis urna cursus eget. Leo vel fringilla est ullamcorper eget nulla facilisi etiam. Nisl rhoncus mattis rhoncus urna neque viverra justo. Ipsum consequat nisl vel pretium lectus quam. Faucibus et molestie ac feugiat sed. Ullamcorper eget nulla facilisi etiam dignissim. Malesuada fames ac turpis egestas."
, "/images/k.png");
addReceivedMessage("Pellentesque habitant morbi tristique senectus et. Volutpat ac tincidunt vitae semper quis lectus nulla. Vestibulum rhoncus est pellentesque elit ullamcorper dignissim cras tincidunt lobortis. Diam vel quam elementum pulvinar etiam non quam lacus. Eget nullam non nisi est sit. Turpis nunc eget lorem dolor sed viverra ipsum nunc aliquet. Pretium viverra suspendisse potenti nullam ac tortor. Maecenas ultricies mi eget mauris pharetra et. Massa vitae tortor condimentum lacinia. Id leo in vitae turpis massa sed. Commodo nulla facilisi nullam vehicula. Duis at consectetur lorem donec massa sapien faucibus et. Volutpat sed cras ornare arcu dui vivamus arcu felis. Suscipit tellus mauris a diam maecenas sed enim ut sem. Netus et malesuada fames ac turpis egestas maecenas pharetra."
, "/images/j.jpg");