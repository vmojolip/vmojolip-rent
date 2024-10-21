$(document).ready(function() {
    let vehicles = [];
    let closeKey = 27;

    window.addEventListener('message', function(event) {
        if (event.data.action === 'updateVehicles') {
            vehicles = event.data.vehicles;
            updateVehicleUI();
        } else if (event.data.action === 'showrent') {
            if (event.data.display) {
                $('.rentuimain').css('display', 'flex');
            } else {
                $('.rentuimain').css('display', 'none');
            }
        } else if (event.data.action === 'closekey') {
            closeKey = event.data.closeKey;
        }
    });

    $(document).keydown(function(e) {
        if (e.keyCode === closeKey) {
            $.post(`https://${GetParentResourceName()}/closeMenu`, JSON.stringify({}));
        }
    });

    let currentIndex = 0;
    const defaultImg = 'img/notfound.png';

    function updateVehicleUI() {
        $('.vehicles-container').empty();
        for (let i = currentIndex; i < currentIndex + 3 && i < vehicles.length; i++) {
            let vehicle = vehicles[i];
            let vehicleDiv = `
                <div class="vehicles">
                    <div class="vehicleprice">
                        <span class="amount">${vehicle.price}</span>
                        <span class="currency">$</span>
                    </div>
                    <img class="vehicleimg" src="${vehicle.img}" onerror="this.onerror=null; this.src='${defaultImg}'; return true;">
                    <div class="vehiclename">${vehicle.name}</div>
                    <button class="selectvehicle" data-index="${i}">Wybierz</button>
                </div>`;
            $('.vehicles-container').append(vehicleDiv);
        }
        
        $('.selectvehicle').click(function() {
            const vehicleIndex = $(this).data('index');
            const selectedVehicle = vehicles[vehicleIndex];

            $.post(`https://${GetParentResourceName()}/selectVehicle2`, JSON.stringify({
                nameveh: selectedVehicle.name,
                priceveh: selectedVehicle.price,
                modelveh: selectedVehicle.model
            }));

            $.post(`https://${GetParentResourceName()}/closeMenu`, JSON.stringify({}));
        });
    }

    $('.nextvehicle').click(function() {
        if (currentIndex + 3 < vehicles.length) {
            currentIndex += 3;
            updateVehicleUI();
        }
    });

    $('.backvehicle').click(function() {
        if (currentIndex - 3 >= 0) {
            currentIndex -= 3;
            updateVehicleUI();
        }
    });

    updateVehicleUI();
});
